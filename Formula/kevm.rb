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
  depends_on "jemalloc"
  depends_on "cryptopp"
  depends_on "libyaml"
  depends_on "jemalloc"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libffi"
  depends_on "openssl" => :build

  bottle do
    root_url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0b6/"
    cellar :any
    sha256 "75debd13f28b55abc8250555572159d9ace7d85ffed03a990c035d341dfd53ed" => :sierra
  end

  def install
    system "make", "BUILD_LOCAL=#{prefix}", "libsecp256k1"
    system "make", "K_RELEASE=/usr/local/lib/kframework", "LIBFF_CC=clang", "LIBFF_CXX=clang++", "BUILD_LOCAL=#{prefix}", "build-node"
    system "make", "K_RELEASE=/usr/local/lib/kframework", "INSTALL_PREFIX=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
