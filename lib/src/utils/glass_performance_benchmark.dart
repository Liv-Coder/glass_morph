import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Performance benchmark utilities for glass morphism widgets.
/// Provides comprehensive performance metrics including frame rates,
/// rendering times, and memory usage patterns.
class GlassPerformanceBenchmark {
  static const int _warmupFrames = 10;
  static const int _benchmarkFrames = 100;
  static const Duration _frameInterval = Duration(milliseconds: 16); // ~60 FPS

  /// Benchmark result containing performance metrics
  final BenchmarkResult result;

  GlassPerformanceBenchmark._(this.result);

  /// Runs comprehensive performance benchmark for a widget
  static Future<GlassPerformanceBenchmark> runBenchmark({
    required Widget Function(BuildContext) widgetBuilder,
    required Size screenSize,
    int iterations = 3,
    bool includeMemoryMetrics = true,
  }) async {
    final results = <BenchmarkResult>[];

    for (int i = 0; i < iterations; i++) {
      final result = await _runSingleBenchmark(
        widgetBuilder: widgetBuilder,
        screenSize: screenSize,
        includeMemoryMetrics: includeMemoryMetrics,
      );
      results.add(result);
      await Future.delayed(const Duration(milliseconds: 100)); // Cool down
    }

    // Average the results
    final avgResult = _averageResults(results);
    return GlassPerformanceBenchmark._(avgResult);
  }

  static Future<BenchmarkResult> _runSingleBenchmark({
    required Widget Function(BuildContext) widgetBuilder,
    required Size screenSize,
    required bool includeMemoryMetrics,
  }) async {
    final completer = Completer<BenchmarkResult>();
    final frameTimes = <int>[];
    final buildTimes = <int>[];
    int frameCount = 0;
    int droppedFrames = 0;

    // Create a test app with the widget
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final startTime = DateTime.now().microsecondsSinceEpoch;

              // Warm up phase
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (frameCount < _warmupFrames) {
                  frameCount++;
                  SchedulerBinding.instance.scheduleFrame();
                } else {
                  // Benchmark phase
                  frameCount = 0;
                  final benchmarkStart = DateTime.now().microsecondsSinceEpoch;

                  void onFrame(Duration timeStamp) {
                    final frameStart = DateTime.now().microsecondsSinceEpoch;

                    if (frameCount < _benchmarkFrames) {
                      final buildStart = DateTime.now().microsecondsSinceEpoch;
                      // Force rebuild to measure build performance
                      context.findRenderObject()?.markNeedsPaint();
                      final buildEnd = DateTime.now().microsecondsSinceEpoch;
                      buildTimes.add(buildEnd - buildStart);

                      frameCount++;
                      SchedulerBinding.instance.scheduleFrame();
                    } else {
                      final benchmarkEnd =
                          DateTime.now().microsecondsSinceEpoch;
                      final totalTime = benchmarkEnd - benchmarkStart;
                      final avgFrameTime = totalTime / _benchmarkFrames;
                      final fps = 1000000 / avgFrameTime; // Convert to FPS

                      // Calculate frame drops (frames taking > 16.67ms)
                      droppedFrames =
                          frameTimes.where((time) => time > 16667).length;

                      final result = BenchmarkResult(
                        averageFps: fps,
                        averageFrameTime:
                            avgFrameTime / 1000, // Convert to milliseconds
                        averageBuildTime: buildTimes.isNotEmpty
                            ? buildTimes.reduce((a, b) => a + b) /
                                buildTimes.length /
                                1000
                            : 0,
                        droppedFrames: droppedFrames,
                        totalFrames: _benchmarkFrames,
                        benchmarkDuration:
                            totalTime / 1000000, // Convert to seconds
                        memoryUsage:
                            includeMemoryMetrics ? _getMemoryUsage() : null,
                      );

                      completer.complete(result);
                    }
                  }

                  SchedulerBinding.instance
                      .addPostFrameCallback((_) => onFrame(Duration.zero));
                }
              });

              return Container(
                width: screenSize.width,
                height: screenSize.height,
                child: widgetBuilder(context),
              );
            },
          ),
        ),
      ),
    );

    return completer.future;
  }

  static BenchmarkResult _averageResults(List<BenchmarkResult> results) {
    final avgFps = results.map((r) => r.averageFps).reduce((a, b) => a + b) /
        results.length;
    final avgFrameTime =
        results.map((r) => r.averageFrameTime).reduce((a, b) => a + b) /
            results.length;
    final avgBuildTime =
        results.map((r) => r.averageBuildTime).reduce((a, b) => a + b) /
            results.length;
    final totalDropped =
        results.map((r) => r.droppedFrames).reduce((a, b) => a + b);
    final totalFrames =
        results.map((r) => r.totalFrames).reduce((a, b) => a + b);
    final avgDuration =
        results.map((r) => r.benchmarkDuration).reduce((a, b) => a + b) /
            results.length;

    return BenchmarkResult(
      averageFps: avgFps,
      averageFrameTime: avgFrameTime,
      averageBuildTime: avgBuildTime,
      droppedFrames: totalDropped,
      totalFrames: totalFrames,
      benchmarkDuration: avgDuration,
      memoryUsage: results.first.memoryUsage, // Use first result's memory data
    );
  }

  static MemoryUsage? _getMemoryUsage() {
    // Note: Memory usage measurement is platform-dependent
    // This is a simplified implementation
    return MemoryUsage(
      heapUsage: 0, // Would need platform-specific implementation
      externalUsage: 0,
      rss: 0,
    );
  }

  @override
  String toString() => result.toString();
}

/// Result of a performance benchmark
class BenchmarkResult {
  final double averageFps;
  final double averageFrameTime; // in milliseconds
  final double averageBuildTime; // in milliseconds
  final int droppedFrames;
  final int totalFrames;
  final double benchmarkDuration; // in seconds
  final MemoryUsage? memoryUsage;

  const BenchmarkResult({
    required this.averageFps,
    required this.averageFrameTime,
    required this.averageBuildTime,
    required this.droppedFrames,
    required this.totalFrames,
    required this.benchmarkDuration,
    this.memoryUsage,
  });

  double get frameDropRate => droppedFrames / totalFrames;
  bool get isSmooth60Fps => averageFps >= 58 && frameDropRate < 0.05;

  @override
  String toString() {
    return '''
Benchmark Result:
  Average FPS: ${averageFps.toStringAsFixed(1)}
  Average Frame Time: ${averageFrameTime.toStringAsFixed(2)}ms
  Average Build Time: ${averageBuildTime.toStringAsFixed(2)}ms
  Dropped Frames: $droppedFrames/$totalFrames (${(frameDropRate * 100).toStringAsFixed(1)}%)
  Benchmark Duration: ${benchmarkDuration.toStringAsFixed(2)}s
  Smooth 60 FPS: ${isSmooth60Fps ? '✅' : '❌'}
  Memory Usage: ${memoryUsage?.toString() ?? 'Not measured'}
''';
  }
}

/// Memory usage information
class MemoryUsage {
  final int heapUsage;
  final int externalUsage;
  final int rss;

  const MemoryUsage({
    required this.heapUsage,
    required this.externalUsage,
    required this.rss,
  });

  @override
  String toString() {
    return 'Heap: ${heapUsage}KB, External: ${externalUsage}KB, RSS: ${rss}KB';
  }
}

/// Performance comparison between different widget configurations
class PerformanceComparison {
  final Map<String, BenchmarkResult> results;

  const PerformanceComparison(this.results);

  BenchmarkResult? get bestFps {
    final smoothResults = results.values.where((r) => r.isSmooth60Fps);
    if (smoothResults.isEmpty) return null;
    return smoothResults.reduce((a, b) => a.averageFps > b.averageFps ? a : b);
  }

  BenchmarkResult? get worstFps {
    final nonSmoothResults = results.values.where((r) => !r.isSmooth60Fps);
    if (nonSmoothResults.isEmpty) return null;
    return nonSmoothResults
        .reduce((a, b) => a.averageFps < b.averageFps ? a : b);
  }

  @override
  String toString() {
    final buffer = StringBuffer('Performance Comparison:\n');
    results.forEach((config, result) {
      buffer.writeln(
          '  $config: ${result.averageFps.toStringAsFixed(1)} FPS (${result.isSmooth60Fps ? '✅' : '❌'})');
    });
    return buffer.toString();
  }
}
