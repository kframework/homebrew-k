class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0-3efa855/kevm-1.0.0-src.tar.gz"
  sha256 "836b23c1b784f5d6c7bae266ede4b95112fe3fab5cd64c0f0e6dd12c1a6b7fc1"
  depends_on "kframework" => :build
  depends_on "protobuf"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pandoc" => :build
  depends_on "cmake" => :build
  depends_on "llvm@8" => :build
  depends_on "jemalloc"
  depends_on "cryptopp"
  depends_on "libyaml"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libffi"
  depends_on "z3" => :build
  depends_on "openssl@1.1" => :build

  bottle do
    root_url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0-3efa855/"
    cellar :any
    sha256 "8d818476507f17dded73a15982b021351c3a6b95d0784ba3d287384d3a43add8" => :mojave
  end

  def install
    system "make", "BUILD_LOCAL=#{prefix}", "libsecp256k1"
    system "make", "K_RELEASE=/usr/local/lib/kframework", "RELEASE=1", "LIBFF_CC=clang", "LIBFF_CXX=clang++", "BUILD_LOCAL=#{prefix}", "build-node"
    system "make", "K_RELEASE=/usr/local/lib/kframework", "RELEASE=1", "BUILD_LOCAL=#{prefix}", "INSTALL_PREFIX=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
