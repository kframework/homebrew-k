class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0-a47e4b2/kevm-1.0.0-src.tar.gz"
  sha256 "6e9d595312109cd3dcab339a6f0fa264adb5ac32813e23e1327ed16dce6bd950"
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
  depends_on "jemalloc"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libffi"
  depends_on "openssl" => :build

  bottle do
    root_url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0-a47e4b2/"
    cellar :any
    rebuild 1
    sha256 "b71ff3c060e327c9a544b28a3c9b636bdb7126883491c01134753fd7842bc36b" => :mojave
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
