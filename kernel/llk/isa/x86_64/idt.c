#include "include/idt.h"

#include "hlk/log/include/string.h"

void set_gate_descriptor(void *const dest, const uint64_t offset, const uint16_t segment_selector, const enum gate_type type, const bool is_present)
{
        // clear the entire gate descriptor
        memset(dest, 0, 128);
        // access the gate descriptor via a pointer that is treated as an array of two uint64_t
        uint64_t *const target = dest;

        // offset[15:0] = target[15:0]
        target[0] &= (offset & 0xFFFF);
        // segment selector[15:0] = target[31:16]
        target[0] &= ((uint64_t) segment_selector << 16);
        // gate type[3:0] = target[43:40]
        target[0] &= (((uint64_t) type & 0xF) << 40);
        // present = target[47]
        target[0] &= (((uint64_t) (is_present ? 1 : 0)) << 47);
        // offset[31:16] = target[63:48]
        target[0] &= ((offset & 0xFF00) << 48);
        // offset[63:32] = target[95:64]
        target[1] &= ((offset & 0xFFFF0000));
}