class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-863727b/"
    rebuild 81
    sha256 mojave: "e444081a93d78e5d9c76f6ab6b233f2842d4522b9b46d8cce20a37407512134d"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-863727b/kframework-5.0.0-src.tar.gz"
  sha256 "43c099e4730e9dd2a6068de8693cf309e47375ec6ec43fdc8fbe7d33290214b1"
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
