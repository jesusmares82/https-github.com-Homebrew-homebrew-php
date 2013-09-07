require 'formula'

class Phpsh < Formula
  homepage 'http://www.phpsh.org/'
  url 'https://github.com/facebook/phpsh/archive/1.3.tar.gz'
  sha1 'cc5b28667514047b286b587f8f054495eef2c654'

  depends_on 'pcre'
  depends_on :python

  def install
    python do
      system python, "setup.py", "install", "--prefix=#{prefix}"
    end

    man1.install ['src/doc/phpsh.1']
    rm_rf("#{prefix}/man")
    bin.install ['src/phpsh']
  end
end
