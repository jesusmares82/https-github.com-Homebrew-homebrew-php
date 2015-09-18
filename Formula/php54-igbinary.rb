require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Igbinary < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/igbinary"
  url "https://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  depends_on 'igbinary' => :build

  bottle do
    cellar :any
    sha256 "586fc7514fc3a00e91ad2db91d82c855dfc21c92ed7fbfe3fa4482665872f018" => :yosemite
    sha256 "92a7e643bac7c8a0683428e37c732bcc329eae531e0b936d929ff1b6b2f4d497" => :mavericks
    sha256 "771f2bbd1a0c249a77d0aacddede5075d2405757e356543f21b86b91e89d1eda" => :mountain_lion
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end

  test do
    shell_output("php -m").include?("igbinary")
  end
end

