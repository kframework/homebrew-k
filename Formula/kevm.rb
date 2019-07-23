class Kevm < Formula
  desc "KEVM 1.0.0"
  homepage ""
  url "https://github.com/kframework/evm-semantics/releases/download/v1.0.0b2/kevm-1.0.0b2.tar.gz"
  sha256 "1462e74411e132576d5c6fbf6440ef54e3820b836892927e9362c883af446769"
  depends_on "kframework" => :build
  depends_on "protobuf" => :build
  depends_on "pandoc" => :build
  depends_on "cmake" => :build
  depends_on "jemalloc"
  depends_on "cryptopp"

  def install
    system "make", "K_RELEASE=/usr/lib/kframework", "LIBFF_CC=clang", "LIBFF_CXX=clang++", "build-node"
    system "make", "K_RELEASE=/usr/lib/kframework", "INSTALL_PREFIX=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
