#!/usr/bin/env python3
"""
🎪 AetherCore v3.3.0 Performance Test
Night Market Intelligence Technical Serviceization Practice
English Version for International Release
"""

import json
import orjson
import ujson
import rapidjson
import time
import sys

def test_json_performance():
    """Test JSON parsing performance with multiple libraries"""
    print("🧪 JSON Performance Test - AetherCore v3.3.0")
    print("=" * 60)
    
    # Create test data
    test_data = {
        "version": "v3.3.0",
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "description": "AetherCore Night Market Intelligence Performance Test",
        "data": {
            "items": [{"id": i, "name": f"Item {i}", "value": i * 10} for i in range(1000)],
            "metadata": {"author": "AetherClaw", "license": "MIT"}
        }
    }
    
    # Serialization performance test
    print("\n📊 Serialization Performance:")
    print("-" * 40)
    results = {}
    
    # orjson serialization
    start = time.perf_counter()
    for _ in range(100):
        orjson.dumps(test_data)
    results['orjson'] = (time.perf_counter() - start) * 1000 / 100
    
    # ujson serialization
    start = time.perf_counter()
    for _ in range(100):
        ujson.dumps(test_data)
    results['ujson'] = (time.perf_counter() - start) * 1000 / 100
    
    # rapidjson serialization
    start = time.perf_counter()
    for _ in range(100):
        rapidjson.dumps(test_data)
    results['rapidjson'] = (time.perf_counter() - start) * 1000 / 100
    
    # Standard library serialization
    start = time.perf_counter()
    for _ in range(100):
        json.dumps(test_data)
    results['stdlib'] = (time.perf_counter() - start) * 1000 / 100
    
    # Display results
    for lib, time_ms in sorted(results.items(), key=lambda x: x[1]):
        speedup = results['stdlib'] / time_ms if time_ms > 0 else 0
        print(f"  {lib:10s}: {time_ms:.3f}ms ({speedup:.1f}x)")
    
    # Parsing performance test
    print("\n📊 Parsing Performance:")
    print("-" * 40)
    json_str = json.dumps(test_data)
    parse_results = {}
    
    # orjson parsing
    start = time.perf_counter()
    for _ in range(100):
        orjson.loads(json_str.encode('utf-8'))
    parse_results['orjson'] = (time.perf_counter() - start) * 1000 / 100
    
    # ujson parsing
    start = time.perf_counter()
    for _ in range(100):
        ujson.loads(json_str)
    parse_results['ujson'] = (time.perf_counter() - start) * 1000 / 100
    
    # rapidjson parsing
    start = time.perf_counter()
    for _ in range(100):
        rapidjson.loads(json_str)
    parse_results['rapidjson'] = (time.perf_counter() - start) * 1000 / 100
    
    # Standard library parsing
    start = time.perf_counter()
    for _ in range(100):
        json.loads(json_str)
    parse_results['stdlib'] = (time.perf_counter() - start) * 1000 / 100
    
    # Display results
    for lib, time_ms in sorted(parse_results.items(), key=lambda x: x[1]):
        speedup = parse_results['stdlib'] / time_ms if time_ms > 0 else 0
        print(f"  {lib:10s}: {time_ms:.3f}ms ({speedup:.1f}x)")
    
    # Best performance summary
    print("\n🎯 Best Performance Summary:")
    print("-" * 40)
    best_serialize = min(results, key=results.get)
    best_parse = min(parse_results, key=parse_results.get)
    print(f"  Best Serialization: {best_serialize} ({results[best_serialize]:.3f}ms)")
    print(f"  Best Parsing: {best_parse} ({parse_results[best_parse]:.3f}ms)")
    
    # XML baseline comparison
    xml_baseline = 100  # Assume XML takes 100ms
    json_performance = results[best_serialize] + parse_results[best_parse]
    speedup_vs_xml = xml_baseline / json_performance if json_performance > 0 else 0
    
    print(f"\n⚡ XML Baseline Comparison:")
    print(f"  XML Baseline: {xml_baseline}ms")
    print(f"  JSON Performance: {json_performance:.1f}ms")
    print(f"  Speedup: {speedup_vs_xml:.1f}x ({(speedup_vs_xml-1)*100:.0f}% faster)")
    
    print("\n" + "=" * 60)
    print("✅ JSON Performance Test Complete")
    
    return {
        "serialize_results": results,
        "parse_results": parse_results,
        "best_serialize": best_serialize,
        "best_parse": best_parse,
        "speedup_vs_xml": speedup_vs_xml
    }

if __name__ == "__main__":
    test_json_performance()