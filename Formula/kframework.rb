class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-2631cde/"
    rebuild 49
    sha256 "3b040bfb1f1033aa05e24df9f5ef451cea1e6eb6cdd1b99a7187355172d1c521" => :mojave
  end

  homepage ""
  url "file:////Users/jenkins-slave/workspace/k_master/homebrew-k/../kframework-5.0.0-src.tar.gz"
  sha256 "54e3d858058370bc24449fdcc1acadc803363156a5f3b68206602b1156140302"
  depends_on "maven" => :build
  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "haskell-stack" => :build
  depends_on "libyaml"
  depends_on "jemalloc"
  depends_on "llvm@8"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "z3"
  depends_on "opam"
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = "#{prefix}"

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  def post_install
    ENV["OPAMROOT"] = "#{prefix}/lib/kframework/opamroot"
    ENV["INIT_ARGS"] = "--disable-sandboxing"
    system "#{prefix}/bin/k-configure-opam"
  end

  test do
    system "true"
  end
end
