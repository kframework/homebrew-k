class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-89fed2e/"
    rebuild 71
    sha256 "60c6d7ce2ec7c9ed385e83ddf53cbe2ccece16d69278dc26f07e426710464ef1" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-89fed2e/kframework-5.0.0-src.tar.gz"
  sha256 "4eba74dd3bcb1dcb1d0ee39a812aee3c0ef9fdc3f542d985468cd0151ac55252"
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
