class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-b503abd/"
    rebuild 6
    sha256 "555ccee6b9b31fe02769c195b3301fc9ac40c24034f610683ffbff85154462c7" => :mojave
  end

  homepage ""
  url "file:////Users/jenkins-slave/workspace/k_master/homebrew-k/../kframework-5.0.0-src.tar.gz"
  sha256 "da2ea02c65572c502a23109e3ec5541caeb58af6d55aba271faaa2103adc32b6"
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
