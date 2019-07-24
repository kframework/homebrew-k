class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0b5/kevm-1.0.0b5.tar.gz"
  sha256 "72c742b2e0d0a93c4d9955edfb5b64ed5341fa2c9a173609ca97425e61d200f7"
  depends_on "kframework" => :build
  depends_on "protobuf" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pandoc" => :build
  depends_on "cmake" => :build
  depends_on "jemalloc"
  depends_on "cryptopp"
  depends_on "openssl" => :build

  def install
    system "make", "libsecp256k1"
    system "make", "K_RELEASE=/usr/local/lib/kframework", "LIBFF_CC=clang", "LIBFF_CXX=clang++", "LIBFF_CMAKE_FLAGS=-DWITH_PROCPS=OFF", "build-node"
    system "make", "K_RELEASE=/usr/local/lib/kframework", "INSTALL_PREFIX=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
