# endoze/homebrew-tap

Homebrew formulae for software maintained by [@endoze](https://github.com/endoze).

## How do I install these formulae?

```sh
brew install endoze/tap/<formula>
```

Or tap the repository first, then install by short name:

```sh
brew tap endoze/tap
brew install <formula>
```

Or, in a [`Brewfile`](https://docs.brew.sh/Manpage#bundle-subcommand):

```ruby
tap "endoze/tap"
brew "endoze/tap/<formula>"
```

## Formulae

| Formula | Description | Homepage |
| --- | --- | --- |
| [`jjwt`](Formula/jjwt.rb) | jujutsu-backed worktrunk-compatible workspace manager | <https://github.com/endoze/jjwt> |

## Updating a formula

How you update depends on whether the upstream project ships a prebuilt formula with its release.

### Prebuilt-binary formulae (e.g. `jjwt`)

Projects using [`cargo-dist`](https://opensource.axo.dev/cargo-dist/) (or similar) attach a fully-rendered `<formula>.rb` to each GitHub release. Replace the file in this tap with the new one:

```sh
curl -sL https://github.com/endoze/<repo>/releases/download/<tag>/<formula>.rb > Formula/<formula>.rb
```

Then commit and push. Users pick up the change on their next `brew update`.

### Source-build formulae

For formulae that build from source:

1. Bump `url` to the new tag (e.g. `v0.2.0`).
2. Recompute `sha256` for the release tarball:

   ```sh
   curl -sL https://github.com/endoze/<repo>/archive/refs/tags/<tag>.tar.gz | shasum -a 256
   ```

3. Update the formula and commit.

### Testing locally

```sh
brew install ./Formula/<formula>.rb
brew test ./Formula/<formula>.rb
brew audit --strict --new ./Formula/<formula>.rb
```

(Add `--build-from-source` to `brew install` for source-build formulae.)

## Adding a new formula

Drop a new `<name>.rb` file into `Formula/` (following the conventions in [Homebrew's Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)) and add a row to the table above.

## Documentation

`brew help`, `man brew`, or check [Homebrew's documentation](https://docs.brew.sh).
