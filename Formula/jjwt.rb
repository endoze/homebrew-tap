class Jjwt < Formula
  desc "jujutsu-backed worktrunk-compatible workspace manager"
  homepage "https://github.com/endoze/jjwt"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.0/jjwt-aarch64-apple-darwin.tar.xz"
      sha256 "0e06e7617e7748ea6e2e7c070840e638cdd9b4d6c1d977b77f6585c4ba13f656"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.0/jjwt-x86_64-apple-darwin.tar.xz"
      sha256 "ab9df864e5cf37a278152f2a093d4ead31928831f4c0d2cf1aa718c75a51a3c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.0/jjwt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a9ad3326e683f5e74b1db542908d53e900f73294997cacd78113fa7c67ee2854"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.0/jjwt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "167bfd1ca4c8742e005633c7a80164f91f7e6185c4064466322dec0af69cac5e"
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
