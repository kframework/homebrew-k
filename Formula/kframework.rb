class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-f56167d/"
    sha256 "f0d79bd38f9a76a1fca80cef1f2c52bbe46d314dc31d5d8f109607d98ff7c313" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-f56167d/kframework-5.0.0-src.tar.gz"
  sha256 "e0a43fde20deab524d43c6317a6d2401f836e21505d27b574a7b2cc6fb46b684"
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
