class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-adf2f2d/"
    rebuild 86
    sha256 mojave: "767b5055078c9b6ad917b70324d03fcc1294654dc1d0ffac5bcba9810f690146"
  end

  homepage ""
  url "file:////Users/jenkins-slave/workspace/k_release/homebrew-k/../kframework-5.0.0-src.tar.gz"
  sha256 "1f5a6084a71bc3e181b58b4e90ab3e5a3d7fec79da6d71f77c1eb4eab0efb9cb"
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

  test do
    system "true"
  end
end
