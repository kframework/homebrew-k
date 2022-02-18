class Cryptopp < Formula
  desc "Free C++ class library of cryptographic schemes"
  homepage "https://www.cryptopp.com/"
  url "https://github.com/weidai11/cryptopp/archive/CRYPTOPP_8_3_0.tar.gz"
  sha256 "63304c6f943f435a4e385273e15abb69cff3b85a44663150bf5a6069b84abd43"
  # https://cryptopp.com/wiki/Config.h#Options_and_Defines
  bottle :disable, "Library and clients must be built on the same microarchitecture"
  def install
    system "make", "shared", "all", "CXX=#{ENV.cxx}"
    system "./cryptest.exe", "v"
    system "make", "install", "PREFIX=#{prefix}"
  end
  test do
    (testpath/"test.cpp").write <<~EOS
      #include <cryptopp/sha.h>
      #include <string>
      using namespace CryptoPP;
      using namespace std;
      int main()
      {
        byte digest[SHA1::DIGESTSIZE];
        string data = "Hello World!";
        SHA1().CalculateDigest(digest, (byte*) data.c_str(), data.length());
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lcryptopp", "-o", "test"
    system "./test"
  end
end
