class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0b1/kevm-1.0.0b1.tar.gz"
  sha256 "5cb70b151efa6e55cd13fb63721106cc672a8f57fe98f9a5f6790116cf9e9b2d"
  depends_on "kframework" => :build
  depends_on "protobuf" => :build
  depends_on "pandoc" => :build
  depends_on "llvm@6" => :build
  depends_on "cmake" => :build
  depends_on "jemalloc"
  depends_on "cryptopp"

  def install
    system "make", "K_RELEASE=/usr/lib/kframework", "build-node"
    system "make", "K_RELEASE=/usr/lib/kframework", "INSTALL_PREFIX=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
