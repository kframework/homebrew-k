class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0b6/kevm-1.0.0b6.tar.gz"
  sha256 "44dd710259f4ee7054f858eff440cac21870cc6ab99d4a374ec0202ebba195ca"
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
