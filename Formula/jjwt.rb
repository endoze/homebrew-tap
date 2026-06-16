class Jjwt < Formula
  desc "jujutsu-backed worktrunk-compatible workspace manager"
  homepage "https://github.com/endoze/jjwt"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.2/jjwt-aarch64-apple-darwin.tar.xz"
      sha256 "5efbc24e3b195a5e1ee97925974c780c892d73c778058f8308f0c4b5c67eb979"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.2/jjwt-x86_64-apple-darwin.tar.xz"
      sha256 "715b7eee956c3339b03ffa37548aa5a391e70f1c02e31cc4d93d4bbed0082d87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.2/jjwt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7772158cf2909a97e17688f129373dc1215132f25f1fc857bf5c87ac1de7884f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.2/jjwt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60efb86bda890aace8d478d7b2910bc0948ed66e2610bf5b0e922a6e471da511"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "jjwt" if OS.mac? && Hardware::CPU.arm?
    bin.install "jjwt" if OS.mac? && Hardware::CPU.intel?
    bin.install "jjwt" if OS.linux? && Hardware::CPU.arm?
    bin.install "jjwt" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
