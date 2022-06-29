class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/runtimeverification/k/releases/download/v5.3.94/kframework-5.3.94-src.tar.gz"
  sha256 "92d91220e6e6da0047acc90013d932a492ff8ba45ca9559aaccf6ddaf8b63bfc"
  bottle do
    root_url "https://github.com/runtimeverification/k/releases/download/v5.3.94/"
    rebuild 217
    sha256 cellar: :any, big_sur: "7155f0951d4789f64357b0b90e0b1f2955a79882d104a9e594d9b1e278f73b1c"
  end
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "haskell-stack" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"
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
