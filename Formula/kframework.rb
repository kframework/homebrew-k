class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-0a12faf/"
    rebuild 78
    sha256 mojave: "c861464c3f5359757c547943dacb004fca3af58caf0979ffe2ed5ee6766a1a0f"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-0a12faf/kframework-5.0.0-src.tar.gz"
  sha256 "9ebe21fd41ab9acf415cf98dfc0fadcf3a145b53018c8acbe4421abbb8eabf47"
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
