class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/nightly-167070995/"
    cellar :any
    sha256 "6dab767d615600951199c7ccf12e54993c18d299915e34c28b770e049195402e" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/nightly-167070995/kframework-5.0.0-src.tar.gz"
  sha256 "ac72ceb8ca5ddd75ef1d6e0b32b0d01410916a910e50cba1e107324e8fb96faa"
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
