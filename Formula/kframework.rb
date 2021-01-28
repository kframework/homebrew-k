class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-62ed02e/"
    rebuild 72
    sha256 "2ff5fe70e505803306cfbc8232865377c1255df72a0676e8c904c7ad657f9c6a" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-62ed02e/kframework-5.0.0-src.tar.gz"
  sha256 "709db1b1ff0ee145b1063150ebcc3f134d82abffd9f6fa2e6f5c23c2b5b18920"
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
