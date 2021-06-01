class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.41/"
    rebuild 12
    sha256 mojave: "75c8482666bb9dae993f6c98e1f8240aeedea1cf8c4edfe009ea4dac2ed0d069"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.1.41/kframework-5.1.41-src.tar.gz"
  sha256 "cfa43d6f38c3ded682648ee9e299176bdb9458eedce547b8927f4f1985ac27a8"
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
