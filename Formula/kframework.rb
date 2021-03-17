class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-0569603/"
    rebuild 88
    sha256 mojave: "4b525b8cf5e0de6d321260dfd3585308d345996bd544df71bb497531d835de84"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-0569603/kframework-5.0.0-src.tar.gz"
  sha256 "64f893ef105d471a90f391f1bfa84b1dbe9d2c6adda8046d217cd34e5190ea49"
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
