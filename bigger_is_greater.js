/* Simple Hello World in Node.js */
function biggerIsGreater(w) {
  for (let index = w.length - 2; index >= 0; index -= 1) {
    for (let tailIndex = w.length - 1; tailIndex > index; tailIndex -= 1) {
      if (w[index] < w[tailIndex]) {
        w = swapChar(w, index, tailIndex)
        return sortString(w, index+1)
      }
    }
  }
  return 'no answer'
}

function swapChar(str, first, last) {
  return str.substr(0, first)
           + str[last]
           + str.substring(first+1, last)
           + str[first]
           + str.substr(last+1);
  return str
}

function sortString(w, fromIndex) {
  return w.slice(0, fromIndex) + w.slice(fromIndex, w.length).split("").reverse().join("")
}


console.log(biggerIsGreater("hefg"))