class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0b3/kevm-1.0.0b3.tar.gz"
  sha256 "6964a200f109078f3558b25878ff9753476b7c406ecddfda94f4bec4b2b36d46"
  depends_on "kframework" => :build
  depends_on "protobuf" => :build
  depends_on "pandoc" => :build
  depends_on "cmake" => :build
  depends_on "jemalloc"
  depends_on "cryptopp"
  depends_on "openssl" => :build

  def install
    system "make", "K_RELEASE=/usr/lib/kframework", "LIBFF_CC=clang", "LIBFF_CXX=clang++", "build-node"
    system "make", "K_RELEASE=/usr/lib/kframework", "INSTALL_PREFIX=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
