class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-2440f2e/"
    rebuild 69
    sha256 "1be42b957972e13833e81e9024df54848055a82dc1883a0597c31c993d12befe" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-2440f2e/kframework-5.0.0-src.tar.gz"
  sha256 "b2b37c17a33dfafce99236dbcd8626040fb2b820e66ab5794e8dc5c1ffd3da83"
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
