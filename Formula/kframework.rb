class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/nightly-bf6fb98e7/"
    cellar :any
    sha256 "76884abd5e1d58566e89a3cd28ab36080dff42c3ab761a39ca68199ec023c005" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/nightly-bf6fb98e7/kframework-5.0.0-src.tar.gz"
  sha256 "8b61579b3e2fc0637446c12b0025f62e522281c70986813c137de37228cdd066"
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
