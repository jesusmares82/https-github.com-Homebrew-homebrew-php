require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pdflib < AbstractPhp55Extension
  init
  desc "Creating PDF on the fly with the PDFlib library"
  homepage "http://www.pdflib.com"
  url "https://pecl.php.net/get/pdflib-3.0.4.tgz"
  sha256 "18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e"

  bottle do
    cellar :any
    sha256 "4d96d421a54c429705c94e2dee462b09024ef16d22a93d7e378a8cf21023b81c" => :el_capitan
    sha256 "8565359a80d4932d513ecbfc4c5ae2eb88f79e1a5c0ac84ba0ef4b1f19cb1217" => :yosemite
    sha256 "91b18fdea140e682137748f0e4bb3fe250f79c091728f92c2457f239f0db5911" => :mavericks
  end

  depends_on "pdflib-lite"

  def extension
    "pdf"
  end

  def install
    Dir.chdir "pdflib-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-pdflib=#{Formula["pdflib-lite"].opt_prefix}"
    system "make"
    prefix.install "modules/pdf.so"
    write_config_file if build.with? "config-file"
  end
end
