class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-4e7c3d0/"
    rebuild 70
    sha256 "5bea9197538426fdd4b9fa2186c4775f8292c9d673c3f3a013d55ec40102b089" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-4e7c3d0/kframework-5.0.0-src.tar.gz"
  sha256 "b8e7a52e7e27ba7d290a7801b587080b27b427325c0634171896fe46ef2a3108"
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
