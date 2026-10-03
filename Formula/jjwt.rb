class Jjwt < Formula
  desc "jujutsu-backed worktrunk-compatible workspace manager"
  homepage "https://github.com/endoze/jjwt"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.2.0/jjwt-aarch64-apple-darwin.tar.xz"
      sha256 "e6c2ab6d61535b82c69d105a85bfdf00a1b8b3732a1a4f9f5e0cf6852399976e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.2.0/jjwt-x86_64-apple-darwin.tar.xz"
      sha256 "ae49f62138212b49825b607fa1bb4400179e2216fd85064d4ce1e27869fe6ddb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.2.0/jjwt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07809c9c4eb676630df415ba47cfca33691f35a0488e228e1f17d6520b34c1de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.2.0/jjwt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee7cc7f14b1222dfa70efc5878cdee0d0764e6fe12e324fe0f65d14bf8afbcbf"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jjwt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jjwt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jjwt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jjwt"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
