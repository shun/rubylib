require "date"

from = nil
to = nil

def usage()
  print <<EOF

usage :

ruby wcal <from> <to>
<from>/<to>	: [0-9]{4}-[0-9]{2}
		e.g. 2015-01
EOF
end

def checkOption(opt)
  opt.each{|item|
    if (item =~ /[0-9]{4}-[0-9]{2}$/)
#      print "OK : #{item}\n"
    else
      print "NG : #{item}\n"
      usage()
      return false
    end
  }
  return true
end

def cnvDate(date_)
  return Date.strptime(date_, "%Y-%m-%d")
end

def printCal(date_)
  wk = date_
  cur_month = wk.month
  idx = 7 - wk.wday + 1

  print "\tM\tT\tW\tT\tF\tS\tS\n"
  
  while (cur_month == wk.month)
    printf("%d\t", wk.cweek)
    (wk.wday - 1).times {
      print "\t"
    }
    idx.times{|i|
      printf("%d\t", wk.day)
      wk += 1
      if (cur_month != wk.month)
        break
      end
    }
    idx = 7
    print "\n"
  end
end

ret = checkOption(ARGV)
if (!ret)
  exit
end
  
if (ARGV.length == 2)
  from = cnvDate(ARGV[0] + "-01")
  to = cnvDate(ARGV[1] + "-01")
elsif (ARGV.length == 1)
 from = cnvDate(ARGV[0] + "-01")
end

wk = from
printCal(wk)
print "\n"

wk = wk >> 1
while ((wk <=> to) <= 0)
  printCal(wk)
  print "\n"
  wk = wk >> 1
end

