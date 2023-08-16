

def notvalid (x,y,n)

  if(x<0 || y<0 || x>=n || y>=n)
     true
  else
     false
  end

end



def findDir(n, instructions, startPos, startDir)
    

    changeDirMap = {
        N: {
            U: 'N',
            D: 'S',
            L: 'W',
            R: 'E' 
        },
        S: {
            U: 'S',
            D: 'N',
            L: 'E',
            R: 'W'
        },
        E: {
            U: 'E',
            D: 'W',
            L: 'N',
            R: 'S'
        },
        W: {
            U: 'W',
            D: 'E',
            L: 'S',
            R: 'N'
        }
    }
    currentDir = startDir
    currentPos = startPos

    instructions.each_char do |instruction|

        x,y = currentPos
        next_dir = changeDirMap[currentDir.to_sym][instruction.to_sym]
        case next_dir
        when 'N'
            x-=1;
            return -1 if notvalid(x,y,n)
        when 'S'
            x+=1
            return -1 if notvalid(x,y,n)
        when 'E'
            y+=1;
            return -1 if notvalid(x,y,n)
        when 'W'
            y-=1
            return -1 if notvalid(x,y,n)
        else

        end

        currentPos[0] = x;
        currentPos[1] = y;
        currentDir = next_dir

    end
    currentDir
end

            

puts findDir(10, "UDLRLRRD", [5,5], "N")