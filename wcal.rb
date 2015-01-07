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
  wday = wk.wday == 0 ? 7 : wk.wday

  print "\tM\tT\tW\tT\tF\tS\tS\n"

  
  printf("%d\t", wk.cweek)
  (wday - 1).times{
    print "\t"
  }

  (7 - (wday - 1)).times{
    printf("%d\t", wk.day)
    wk += 1
  }
  print "\n"
  rowcnt = 1
  while (cur_month == wk.month)
    printf("%d\t", wk.cweek)
    7.times{|i|
      printf("%d\t", wk.day)
      wk += 1
      if (cur_month != wk.month)
        break
      end
    }
    rowcnt += 1
    print "\n"
  end

  if (rowcnt < 6)
    print "\n"
  end
end

ret = checkOption(ARGV)
if (!ret)
  exit
end

print "\n"
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

if (to == nil)
  exit
end

while ((wk <=> to) <= 0)
  printCal(wk)
  print "\n"
  wk = wk >> 1
end

