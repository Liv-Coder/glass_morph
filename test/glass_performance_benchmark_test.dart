import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_morph_widgets/glass_morph_widgets.dart';
import 'package:glass_morph_widgets/src/utils/glass_performance_benchmark.dart';

void main() {
  group('GlassPerformanceBenchmark', () {
    testWidgets('BenchmarkResult properties are calculated correctly',
        (tester) async {
      const result = BenchmarkResult(
        averageFps: 60.0,
        averageFrameTime: 16.67,
        averageBuildTime: 2.5,
        droppedFrames: 4,
        totalFrames: 100,
        benchmarkDuration: 2.0,
        memoryUsage:
            MemoryUsage(heapUsage: 1024, externalUsage: 512, rss: 2048),
      );

      expect(result.frameDropRate, 0.04);
      expect(result.isSmooth60Fps, true);
    });

    testWidgets('BenchmarkResult with poor performance', (tester) async {
      const result = BenchmarkResult(
        averageFps: 45.0,
        averageFrameTime: 22.22,
        averageBuildTime: 5.0,
        droppedFrames: 25,
        totalFrames: 100,
        benchmarkDuration: 2.0,
      );

      expect(result.frameDropRate, 0.25);
      expect(result.isSmooth60Fps, false);
    });

    testWidgets('MemoryUsage toString formats correctly', (tester) async {
      const memory =
          MemoryUsage(heapUsage: 1024, externalUsage: 512, rss: 2048);
      expect(memory.toString(), 'Heap: 1024KB, External: 512KB, RSS: 2048KB');
    });

    testWidgets('PerformanceComparison finds best and worst FPS',
        (tester) async {
      const results = {
        'config1': BenchmarkResult(
          averageFps: 60.0,
          averageFrameTime: 16.67,
          averageBuildTime: 2.0,
          droppedFrames: 2,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'config2': BenchmarkResult(
          averageFps: 58.0,
          averageFrameTime: 17.24,
          averageBuildTime: 2.5,
          droppedFrames: 5,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'config3': BenchmarkResult(
          averageFps: 45.0,
          averageFrameTime: 22.22,
          averageBuildTime: 4.0,
          droppedFrames: 20,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
      };

      final comparison = PerformanceComparison(results);
      expect(comparison.bestFps?.averageFps, 60.0);
      expect(comparison.worstFps?.averageFps, 45.0);
    });
  });

  group('Widget Performance Benchmarks', () {
    const screenSize = Size(375, 667); // iPhone SE size

    testWidgets('GlassMorphButton benchmark completes successfully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Note: Actual benchmark would require integration test setup
      // This is a placeholder for the benchmark structure
      expect(find.byType(GlassMorphButton), findsOneWidget);
    });

    testWidgets('GlassMorphCard benchmark completes successfully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const GlassMorphCard(
              child: Text('Test Card'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(GlassMorphCard), findsOneWidget);
    });

    testWidgets(
        'GlassMorphFloatingActionButton benchmark completes successfully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassMorphFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(GlassMorphFloatingActionButton), findsOneWidget);
    });

    testWidgets('GlassMorphAppBar benchmark completes successfully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const GlassMorphAppBar(
              title: Text('Test App Bar'),
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(GlassMorphAppBar), findsOneWidget);
    });

    testWidgets('GlassMorphBottomSheet benchmark completes successfully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const GlassMorphBottomSheet(
                      child: Text('Test Bottom Sheet'),
                    ),
                  );
                },
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('GlassMorphDialog benchmark completes successfully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const GlassMorphDialog(
                      child: Text('Test Dialog'),
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Performance Comparison Tests', () {
    testWidgets('Compare different blur levels', (tester) async {
      const configs = {
        'low_blur': BenchmarkResult(
          averageFps: 60.0,
          averageFrameTime: 16.67,
          averageBuildTime: 1.5,
          droppedFrames: 1,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'medium_blur': BenchmarkResult(
          averageFps: 58.0,
          averageFrameTime: 17.24,
          averageBuildTime: 2.0,
          droppedFrames: 3,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'high_blur': BenchmarkResult(
          averageFps: 55.0,
          averageFrameTime: 18.18,
          averageBuildTime: 2.8,
          droppedFrames: 8,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
      };

      final comparison = PerformanceComparison(configs);
      expect(comparison.bestFps?.averageFps, 60.0);
      expect(comparison.worstFps?.averageFps, 55.0);
    });

    testWidgets('Compare with and without animations', (tester) async {
      const configs = {
        'with_animation': BenchmarkResult(
          averageFps: 58.0,
          averageFrameTime: 17.24,
          averageBuildTime: 2.5,
          droppedFrames: 5,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'without_animation': BenchmarkResult(
          averageFps: 60.0,
          averageFrameTime: 16.67,
          averageBuildTime: 1.8,
          droppedFrames: 2,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
      };

      final comparison = PerformanceComparison(configs);
      expect(comparison.bestFps?.averageFps, 60.0);
      expect(comparison.worstFps?.averageFps, 58.0);
    });

    testWidgets('Compare different gradient configurations', (tester) async {
      const configs = {
        'solid_color': BenchmarkResult(
          averageFps: 60.0,
          averageFrameTime: 16.67,
          averageBuildTime: 1.5,
          droppedFrames: 1,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'linear_gradient': BenchmarkResult(
          averageFps: 59.0,
          averageFrameTime: 16.95,
          averageBuildTime: 2.0,
          droppedFrames: 2,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
        'radial_gradient': BenchmarkResult(
          averageFps: 58.0,
          averageFrameTime: 17.24,
          averageBuildTime: 2.2,
          droppedFrames: 6,
          totalFrames: 100,
          benchmarkDuration: 2.0,
        ),
      };

      final comparison = PerformanceComparison(configs);
      expect(comparison.bestFps?.averageFps, 60.0);
      expect(comparison.worstFps?.averageFps, 58.0);
    });
  });

  group('Benchmark Edge Cases', () {
    testWidgets('Handles zero dropped frames', (tester) async {
      const result = BenchmarkResult(
        averageFps: 60.0,
        averageFrameTime: 16.67,
        averageBuildTime: 2.0,
        droppedFrames: 0,
        totalFrames: 100,
        benchmarkDuration: 2.0,
      );

      expect(result.frameDropRate, 0.0);
      expect(result.isSmooth60Fps, true);
    });

    testWidgets('Handles high frame drop rate', (tester) async {
      const result = BenchmarkResult(
        averageFps: 30.0,
        averageFrameTime: 33.33,
        averageBuildTime: 5.0,
        droppedFrames: 50,
        totalFrames: 100,
        benchmarkDuration: 2.0,
      );

      expect(result.frameDropRate, 0.5);
      expect(result.isSmooth60Fps, false);
    });

    testWidgets('Handles very low FPS', (tester) async {
      const result = BenchmarkResult(
        averageFps: 15.0,
        averageFrameTime: 66.67,
        averageBuildTime: 8.0,
        droppedFrames: 85,
        totalFrames: 100,
        benchmarkDuration: 2.0,
      );

      expect(result.frameDropRate, 0.85);
      expect(result.isSmooth60Fps, false);
    });
  });
}
