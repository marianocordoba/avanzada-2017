/**
 * @pre {x >= 0 ^ y >= 0 ^ x = X ^ y = Y}
 * @pos {r = X^Y}
 */
function exp(X, Y) {
    var x = X
    var y = Y
    var r = 1

    while (y != 0) {
        if (y % 2 == 0) {
            x = x * x
            y = Math.floor(y/2)
        } else if (y % 2 == 1) {
            r = r * x
            y = y - 1
        }
    }

    return r
}

function parindex(a, N) {
    var b = true
    var n = 0

    while (n < N) {
        if (n % 2 == 0)
            b = b && a[n] % 2 == 0
        n++
    }

    return b
}

console.log(parindex([0,1,2,3,4,5,6], 7))