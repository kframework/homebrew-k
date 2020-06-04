class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-0cf586c/"
    sha256 "e7f2f1bea37f1cab74a47a2d2239c155a24aad9051c1ef63e7a975d589784610" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-0cf586c/kframework-5.0.0-src.tar.gz"
  sha256 "31cecc0d0202247994a9315bb2b1c6f6be0a8db0a7fb8ba60bdba62d4f84e7bd"
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
