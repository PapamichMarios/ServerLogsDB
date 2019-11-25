export default function decodeTimestamp (toDecode) {

    var decoded = toDecode.split('T');

    /*  check time is followed by seconds
        giving 00 at the seconds sends timestamp without them*/
    if (decoded[1].length !== 8) {
        decoded[1] = decoded[1] + ":00";
    }

    return decoded;
}