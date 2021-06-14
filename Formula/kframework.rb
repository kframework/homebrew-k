class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.62/"
    rebuild 20
    sha256 mojave: "9fe36ae9d2d600535b4a47f0f59e19084213b25a22a1159c5154b8379838629e"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.1.62/kframework-5.1.62-src.tar.gz"
  sha256 "27cdf29b6006bdd384ef0de176cf6c2651aca710bd86eb63d9d7c532db1ec642"
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
