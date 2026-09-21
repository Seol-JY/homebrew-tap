class Gomoku < Formula
  desc "Play Gomoku (Renju rules) with a friend, in your terminal."
  homepage "https://github.com/Seol-JY/gomoku"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.1/gomoku-aarch64-apple-darwin.tar.xz"
      sha256 "10121aa6d353197a972aaae4a803f76b42cb2984d346ba8cc2325fab56075087"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.1/gomoku-x86_64-apple-darwin.tar.xz"
      sha256 "db13e9e58086b1d67ff44b85b90ac6ac781873216b5dff85190e46c87468efb5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.1/gomoku-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "23db5082c507c85e52dddf152e05126d00ee2c180338ac393095664aaa21a966"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Seol-JY/gomoku/releases/download/v0.1.1/gomoku-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6900e54992ec7b0c1bf48ddf8c7d50f8960f60a811623e1abc196b57b5b9a57e"
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
