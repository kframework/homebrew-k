class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.1.246/kframework-5.1.246-src.tar.gz"
  sha256 "e720f2f3d8b6c66f9f420719b9a24a8a68ce472fd08c3704ca730d87f17bf237"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.246/"
    rebuild 94
    sha256 big_sur: "15ff39d634512e1431388c1212aac8b84a018e6add6b00682dde513fcc3d5261"
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
  depends_on "llvm@12"
  depends_on "mpfr"
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
