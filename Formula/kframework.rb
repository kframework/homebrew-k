class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-7ac809a/"
    rebuild 77
    sha256 mojave: "3d40f3f414e29e40b0870b68a41bfec3b91ca41e84d4c9d3c53c20f27187d8be"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-7ac809a/kframework-5.0.0-src.tar.gz"
  sha256 "deda9bf098ed4a93622ae80d952a5feba4866824ff13fab955a70fce7bd46fa9"
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
