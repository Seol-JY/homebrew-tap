class Gomoku < Formula
  desc "Play Gomoku (Renju rules) with a friend, in your terminal."
  homepage "https://github.com/Seol-JY/gomoku"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.0/gomoku-aarch64-apple-darwin.tar.xz"
      sha256 "24da26c0c9c3e9e96b66d9e77ed04d2a02131a6482c20a63e01adc2e4c7b47d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.0/gomoku-x86_64-apple-darwin.tar.xz"
      sha256 "c5eedc148204ad24fc8c5358049534fa99810dfa742bc2e4a075d61ae43ef2ab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.0/gomoku-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "25e7af5056982d8d38647dea9f51baad69f13ae0dc7d649f79c622066747f1f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.0/gomoku-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "27d57d1dc0c9b53563b7983c2bff9ea259c14ddf6aaf5618d2821860e71ca264"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "gomoku"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gomoku"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gomoku"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gomoku"
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
