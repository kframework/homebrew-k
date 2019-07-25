class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/releases/download/5.1b4/k-5.1b4.tar.gz"
  sha256 "d972dbb316c0c71696234825431518d08496995e8157140cea57070ebe99ca23"
  depends_on "maven" => :build
  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "haskell-stack" => :build
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
    system "sh", "-c", "INIT_ARGS=--disable-sandboxing k-distribution/src/main/scripts/bin/k-configure-opam"
    system "sh", "-c", "export PATH=\"$PATH:$CARGO_HOME/bin\"; mvn package -DskipTests -Dproject.build.type=FastBuild"
    system "sh", "-c", "DESTDIR= PREFIX=#{prefix} src/main/scripts/package"
  end

  test do
    system "true"
  end
end
