class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-e698f30/"
    sha256 "bf4eebcbfe3048d857cdc84b1d79c74a62b0a7c13cba001e4cd7c782e527751a" => :mojave
  end

  homepage ""
  url "file:////Users/jenkins-slave/workspace/k_master/homebrew-k/../kframework-5.0.0-src.tar.gz"
  sha256 "7fa215b07baa5651a6bd752c79a80e401da659282da6c91438cf11a6b39f7850"
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
