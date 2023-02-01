class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.5.80/kframework-5.5.80-src.tar.gz"
  sha256 "1e746d93a5b2f79211511f113dcf011c3c4ed2ee7c067ce665f2e5bc9b9f71df"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.5.80/"
    rebuild 372
    sha256 cellar: :any, big_sur: "b6661e0aa88cf82eaa509faa961f792f85bca75e4a71c0ca03587ac682545b11"
  end
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "haskell-stack" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "fmt"
  depends_on "gmp"
  depends_on "jemalloc"
  depends_on "libyaml"
  depends_on "llvm@13"
  depends_on "mpfr"
  depends_on "openjdk"
  depends_on "z3"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = prefix.to_s
    ENV["HOMEBREW_PREFIX"] = HOMEBREW_PREFIX

    # Unset MAKEFLAGS for `stack setup`.
    # Prevents `install: mkdir ... ghc-7.10.3/lib: File exists`
    # See also: https://github.com/brewsci/homebrew-science/blob/bb52ecc66b6f9fad4d281342139189ae81d7c410/Formula/tamarin-prover.rb#L27
    ENV.deparallelize do
      cd "haskell-backend/src/main/native/haskell-backend" do
        system "stack", "setup"
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  test do
    system "true"
  end
end
