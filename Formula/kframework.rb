class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/releases/download/5.1b2/k-5.1b2.tar.gz"
  sha256 "4d7440d5c6cdb31fb8b8439a19ef1531be9734386acbd7586ab811afed8f1911"
  depends_on "maven" => :build
  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "libyaml"
  depends_on "jemalloc"
  depends_on "llvm@8" => :build
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "z3"
  depends_on "opam"
  depends_on "pkg-config" => :build
  depends_on "bison" => :build
  depends_on "flex"

  def install
#    system "llvm-backend/src/main/native/llvm-backend/install-rust"
    system "sh", "-c", "curl -sSL https://get.haskellstack.org/ | sh"
    system "k-distribution/src/main/scripts/bin/k-configure-opam"
    system "mvn", "package"
    system "sh", "-c", "DESTDIR=#{prefix} src/main/scripts/package"
  end

  test do
    system "true"
  end
end
