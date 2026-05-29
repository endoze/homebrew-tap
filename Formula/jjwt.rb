class Jjwt < Formula
  desc "jujutsu-backed worktrunk-compatible workspace manager"
  homepage "https://github.com/endoze/jjwt"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.1/jjwt-aarch64-apple-darwin.tar.xz"
      sha256 "4932237e807b04611a6c0ceddb70bf170b37d0397acde26608e475b75a929f87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.1/jjwt-x86_64-apple-darwin.tar.xz"
      sha256 "59dbe443fb20bf7fecd97dd250dc4c4262beaf032ebdab81d533e882e7e72e8e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.1/jjwt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b0cd690889fccc6167b9347c2b7e26eaca4eb50c2e8d0721bb3602583b2fa158"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endoze/jjwt/releases/download/v0.1.1/jjwt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fc17273cba5929c0ce4435526a9fb4969759607cb4c5f65296e3df93a72448d1"
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
