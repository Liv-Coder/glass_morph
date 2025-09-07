# GH Pages deployment: Add GH_PAGES_PAT secret

Purpose
Add a Personal Access Token (GH_PAGES_PAT) and update the gh-pages workflow to publish using that token when GITHUB_TOKEN is blocked.

1. Create a Personal Access Token (classic)

- Go to GitHub -> Settings -> Developer settings -> Personal access tokens -> Tokens (classic)
- Click "Generate new token (classic)".
- Name: GH_PAGES_PAT or glass_morph-gh-pages
- Scopes: repo (recommended) — grants access to push to gh-pages. Use the smallest scope your org requires.
- Generate and copy the token now (you will not be able to see it again).

2. Add as a repository secret

- Go to repository -> Settings -> Secrets and variables -> Actions -> New repository secret
- Name: GH_PAGES_PAT
- Value: <paste the token>
- Save

3. Update the workflow
   Edit [`.github/workflows/gh-pages.yml`](.github/workflows/gh-pages.yml:1) and change the Deploy step to pass the personal token:

```yaml
name: Deploy Example to GitHub Pages
---
- name: Deploy to gh-pages
  uses: peaceiris/actions-gh-pages@v3
  with:
    personal_token: ${{ secrets.GH_PAGES_PAT }}
    publish_dir: ./example/build/web
```

4. Create branch, commit and open PR

- git checkout -b ci/gh-pages-pat
- git add .github/workflows/gh-pages.yml
- git commit -m "ci: use GH_PAGES_PAT for gh-pages deploy (org-restricted GITHUB_TOKEN)"
- Push and open PR, request merge.

5. Re-run and verify

- After merge, check Actions -> workflow run logs; confirm peaceiris step finished and files uploaded.
- Verify site: https://<your-org-or-user>.github.io/<repo>/

Troubleshooting

- If the deploy still fails, copy the Actions run log (peaceiris step) and paste it here. I will analyze and provide the minimal change or guidance.
