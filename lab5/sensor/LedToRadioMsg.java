/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'LedToRadioMsg'
 * message type.
 */

public class LedToRadioMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 4;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 6;

    /** Create a new LedToRadioMsg of size 4. */
    public LedToRadioMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new LedToRadioMsg of the given data_length. */
    public LedToRadioMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new LedToRadioMsg with the given data_length
     * and base offset.
     */
    public LedToRadioMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new LedToRadioMsg using the given byte array
     * as backing store.
     */
    public LedToRadioMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new LedToRadioMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public LedToRadioMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new LedToRadioMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public LedToRadioMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new LedToRadioMsg embedded in the given message
     * at the given base offset.
     */
    public LedToRadioMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new LedToRadioMsg embedded in the given message
     * at the given base offset and length.
     */
    public LedToRadioMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <LedToRadioMsg> \n";
      try {
        s += "  [nodeid=0x"+Long.toHexString(get_nodeid())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [sensorValue=0x"+Long.toHexString(get_sensorValue())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: nodeid
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'nodeid' is signed (false).
     */
    public static boolean isSigned_nodeid() {
        return false;
    }

    /**
     * Return whether the field 'nodeid' is an array (false).
     */
    public static boolean isArray_nodeid() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'nodeid'
     */
    public static int offset_nodeid() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'nodeid'
     */
    public static int offsetBits_nodeid() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'nodeid'
     */
    public int get_nodeid() {
        return (int)getUIntBEElement(offsetBits_nodeid(), 16);
    }

    /**
     * Set the value of the field 'nodeid'
     */
    public void set_nodeid(int value) {
        setUIntBEElement(offsetBits_nodeid(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'nodeid'
     */
    public static int size_nodeid() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'nodeid'
     */
    public static int sizeBits_nodeid() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: sensorValue
    //   Field type: int, unsigned
    //   Offset (bits): 16
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'sensorValue' is signed (false).
     */
    public static boolean isSigned_sensorValue() {
        return false;
    }

    /**
     * Return whether the field 'sensorValue' is an array (false).
     */
    public static boolean isArray_sensorValue() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'sensorValue'
     */
    public static int offset_sensorValue() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'sensorValue'
     */
    public static int offsetBits_sensorValue() {
        return 16;
    }

    /**
     * Return the value (as a int) of the field 'sensorValue'
     */
    public int get_sensorValue() {
        return (int)getUIntBEElement(offsetBits_sensorValue(), 16);
    }

    /**
     * Set the value of the field 'sensorValue'
     */
    public void set_sensorValue(int value) {
        setUIntBEElement(offsetBits_sensorValue(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'sensorValue'
     */
    public static int size_sensorValue() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'sensorValue'
     */
    public static int sizeBits_sensorValue() {
        return 16;
    }

}