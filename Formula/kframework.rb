class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/nightly-25fe7e707/"
    cellar :any
    rebuild 1
    sha256 "8a76d80e86f8508e68647a1fc73d5e0d8128130d1a5be03b16719d4bad0a2992" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/nightly-25fe7e707/kframework-5.0.0-src.tar.gz"
  sha256 "e59fb2cfbdf41a86cbf4a7fcba84ba8d996970c9c538b08e9d7fd429fab981ff"
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
  depends_on "bison" => :build
  depends_on "flex"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["PATH"] = ENV["PATH"] + ":" + ENV["CARGO_HOME"] + "/bin"
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = "#{prefix}"

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "src/main/scripts/package"
  end

  def post_install
    ENV["OPAMROOT"] = "#{prefix}/lib/kframework/lib/opamroot"
    ENV["INIT_ARGS"] = "--disable-sandboxing"
    system "#{prefix}/lib/kframework/bin/k-configure-opam"
  end

  test do
    system "true"
  end
end
