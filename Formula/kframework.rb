class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/archive/5.1b2.tar.gz"
  sha256 "c4b577fd23bb87e77eb902083b45dce3556a7f11f5c72011ff0ff474ed298ba8"
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
    system "llvm-backend/src/main/native/llvm-backend/install-rust"
    system "sh", "-c", "curl -sSL https://get.haskellstack.org/ | sh"
    system "k-distribution/src/main/scripts/bin/k-configure-opam"
    system "mvn", "package"
  end

  test do
    system "true"
  end
end
