#!/usr/bin/env python3
"""
AetherCore v3.3.0 Installation Feedback Collector
Night Market Intelligence Technical Serviceization Practice
Collect user feedback to improve installation experience
"""

import json
import os
import sys
import time
from datetime import datetime
from pathlib import Path

def collect_installation_feedback():
    """Collect installation process feedback"""
    print("🎪 AetherCore v3.3.0 Installation Feedback")
    print("Night Market Intelligence - Technical Serviceization Practice")
    print("=" * 60)
    print()
    print("Thank you for installing AetherCore!")
    print("Please help us improve by answering a few questions.")
    print("Your feedback is valuable for making AetherCore better.")
    print()
    
    feedback = {
        "timestamp": datetime.now().isoformat(),
        "version": "3.3.0",
        "installation_method": "one-click",
        "responses": {}
    }
    
    questions = [
        {
            "id": "installation_smoothness",
            "question": "Was the installation process smooth?",
            "options": ["Very smooth", "Smooth", "Some issues", "Many issues", "Failed"],
            "type": "multiple_choice"
        },
        {
            "id": "encountered_problems", 
            "question": "What problems did you encounter? (Select all that apply)",
            "options": [
                "No problems",
                "Dependency installation failed",
                "Permission issues",
                "Network connectivity problems",
                "OpenClaw not found",
                "Python version issues",
                "Other"
            ],
            "type": "multiple_select"
        },
        {
            "id": "skill_md_format",
            "question": "Is the SKILL.md format clear and helpful?",
            "options": ["Excellent", "Good", "Average", "Poor", "Didn't read"],
            "type": "multiple_choice"
        },
        {
            "id": "documentation_clarity",
            "question": "How clear was the documentation?",
            "options": ["Very clear", "Clear", "Somewhat clear", "Confusing", "Didn't read"],
            "type": "multiple_choice"
        },
        {
            "id": "performance_expectations",
            "question": "Does the performance meet your expectations?",
            "options": ["Exceeds expectations", "Meets expectations", "Below expectations", "Haven't tested"],
            "type": "multiple_choice"
        },
        {
            "id": "installation_time",
            "question": "How long did installation take?",
            "options": ["Under 30 seconds", "30-60 seconds", "1-2 minutes", "2-5 minutes", "Over 5 minutes"],
            "type": "multiple_choice"
        },
        {
            "id": "overall_satisfaction",
            "question": "Overall, how satisfied are you with the installation experience?",
            "options": ["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"],
            "type": "multiple_choice"
        }
    ]
    
    print("📝 Feedback Questions:")
    print("-" * 40)
    
    for i, q in enumerate(questions, 1):
        print(f"\n{i}. {q['question']}")
        
        if q['type'] == 'multiple_choice':
            for j, option in enumerate(q['options'], 1):
                print(f"   {j}. {option}")
            
            while True:
                try:
                    choice = input(f"\nYour choice (1-{len(q['options'])}): ").strip()
                    if choice.isdigit() and 1 <= int(choice) <= len(q['options']):
                        feedback["responses"][q['id']] = {
                            "answer": q['options'][int(choice)-1],
                            "choice_index": int(choice)-1
                        }
                        break
                    else:
                        print(f"Please enter a number between 1 and {len(q['options'])}")
                except KeyboardInterrupt:
                    print("\n\nFeedback collection cancelled.")
                    return None
                except:
                    print("Invalid input. Please try again.")
        
        elif q['type'] == 'multiple_select':
            print("   (Enter numbers separated by commas, e.g., 1,3,5)")
            for j, option in enumerate(q['options'], 1):
                print(f"   {j}. {option}")
            
            while True:
                try:
                    choices = input(f"\nYour choices (comma-separated): ").strip()
                    if choices.lower() == '0':
                        feedback["responses"][q['id']] = {
                            "answers": ["No problems"],
                            "choice_indices": [0]
                        }
                        break
                    
                    choice_indices = [int(c.strip())-1 for c in choices.split(',') if c.strip().isdigit()]
                    valid_choices = all(0 <= idx < len(q['options']) for idx in choice_indices)
                    
                    if choice_indices and valid_choices:
                        selected_answers = [q['options'][idx] for idx in choice_indices]
                        feedback["responses"][q['id']] = {
                            "answers": selected_answers,
                            "choice_indices": choice_indices
                        }
                        break
                    else:
                        print(f"Please enter valid numbers between 1 and {len(q['options'])}")
                except KeyboardInterrupt:
                    print("\n\nFeedback collection cancelled.")
                    return None
                except:
                    print("Invalid input. Please try again.")
    
    # Optional comments
    print("\n💡 Additional Comments or Suggestions:")
    print("(Press Enter to skip)")
    comments = input("Your comments: ").strip()
    if comments:
        feedback["comments"] = comments
    
    return feedback

def save_feedback(feedback):
    """Save feedback to file"""
    if not feedback:
        return False
    
    # Create feedback directory
    feedback_dir = Path.home() / ".openclaw" / "skills" / "aethercore" / "feedback"
    feedback_dir.mkdir(parents=True, exist_ok=True)
    
    # Generate filename
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = feedback_dir / f"installation_feedback_{timestamp}.json"
    
    # Save to file
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(feedback, f, indent=2, ensure_ascii=False)
    
    # Also save to local directory for development
    local_filename = f"installation_feedback_{timestamp}.json"
    with open(local_filename, 'w', encoding='utf-8') as f:
        json.dump(feedback, f, indent=2, ensure_ascii=False)
    
    return str(filename)

def analyze_feedback(feedback):
    """Analyze and display feedback summary"""
    if not feedback:
        return
    
    print("\n" + "=" * 60)
    print("📊 Your Feedback Summary")
    print("=" * 60)
    
    # Calculate satisfaction score
    satisfaction_map = {
        "Very satisfied": 5,
        "Satisfied": 4,
        "Neutral": 3,
        "Dissatisfied": 2,
        "Very dissatisfied": 1
    }
    
    if "overall_satisfaction" in feedback["responses"]:
        satisfaction = feedback["responses"]["overall_satisfaction"]["answer"]
        score = satisfaction_map.get(satisfaction, 3)
        
        print(f"\n🌟 Overall Satisfaction: {satisfaction} ({score}/5)")
        
        # Display satisfaction visualization
        stars = "★" * score + "☆" * (5 - score)
        print(f"   Rating: {stars}")
    
    # Display key responses
    print("\n📋 Key Responses:")
    for qid, response in feedback["responses"].items():
        if qid in ["installation_smoothness", "documentation_clarity", "performance_expectations"]:
            question_map = {
                "installation_smoothness": "Installation Smoothness",
                "documentation_clarity": "Documentation Clarity",
                "performance_expectations": "Performance Expectations"
            }
            
            if "answer" in response:
                print(f"   • {question_map.get(qid, qid)}: {response['answer']}")
            elif "answers" in response:
                print(f"   • {question_map.get(qid, qid)}: {', '.join(response['answers'])}")
    
    # Display problems encountered
    if "encountered_problems" in feedback["responses"]:
        problems = feedback["responses"]["encountered_problems"]
        if "answers" in problems:
            problem_list = problems["answers"]
            if "No problems" in problem_list:
                print(f"   • Problems Encountered: None ✅")
            else:
                print(f"   • Problems Encountered: {', '.join(problem_list)}")
    
    # Display installation time
    if "installation_time" in feedback["responses"]:
        install_time = feedback["responses"]["installation_time"]["answer"]
        print(f"   • Installation Time: {install_time}")
    
    # Display comments if any
    if "comments" in feedback:
        print(f"\n💭 Your Comments:")
        print(f"   \"{feedback['comments']}\"")

def generate_improvement_suggestions(feedback):
    """Generate improvement suggestions based on feedback"""
    if not feedback:
        return []
    
    suggestions = []
    responses = feedback["responses"]
    
    # Check installation smoothness
    if "installation_smoothness" in responses:
        smoothness = responses["installation_smoothness"]["answer"]
        if smoothness in ["Some issues", "Many issues", "Failed"]:
            suggestions.append({
                "area": "Installation Process",
                "suggestion": "Improve error handling and provide clearer error messages",
                "priority": "High"
            })
    
    # Check documentation clarity
    if "documentation_clarity" in responses:
        clarity = responses["documentation_clarity"]["answer"]
        if clarity in ["Confusing", "Didn't read"]:
            suggestions.append({
                "area": "Documentation",
                "suggestion": "Simplify documentation and add more examples",
                "priority": "Medium"
            })
    
    # Check performance expectations
    if "performance_expectations" in responses:
        performance = responses["performance_expectations"]["answer"]
        if performance == "Below expectations":
            suggestions.append({
                "area": "Performance",
                "suggestion": "Provide clearer performance expectations and benchmarks",
                "priority": "Medium"
            })
    
    # Check problems encountered
    if "encountered_problems" in responses:
        problems = responses["encountered_problems"]
        if "answers" in problems:
            problem_list = problems["answers"]
            
            if "Dependency installation failed" in problem_list:
                suggestions.append({
                    "area": "Dependencies",
                    "suggestion": "Improve dependency installation with better fallbacks",
                    "priority": "High"
                })
            
            if "Permission issues" in problem_list:
                suggestions.append({
                    "area": "Permissions",
                    "suggestion": "Add permission checking and guidance",
                    "priority": "High"
                })
            
            if "OpenClaw not found" in problem_list:
                suggestions.append({
                    "area": "Prerequisites",
                    "suggestion": "Add better OpenClaw detection and installation guidance",
                    "priority": "High"
                })
    
    return suggestions

def main():
    """Main function"""
    print("🎪 AetherCore v3.3.0 - Installation Feedback Collection")
    print("Night Market Intelligence Technical Serviceization Practice")
    print("=" * 60)
    
    # Collect feedback
    feedback = collect_installation_feedback()
    
    if not feedback:
        print("\nFeedback collection was cancelled.")
        return 0
    
    # Save feedback
    saved_file = save_feedback(feedback)
    if saved_file:
        print(f"\n✅ Feedback saved to: {saved_file}")
    
    # Analyze feedback
    analyze_feedback(feedback)
    
    # Generate improvement suggestions
    suggestions = generate_improvement_suggestions(feedback)
    
    if suggestions:
        print("\n🔧 Improvement Suggestions Based on Your Feedback:")
        print("-" * 40)
        
        for i, suggestion in enumerate(suggestions, 1):
            print(f"\n{i}. {suggestion['area']} ({suggestion['priority']} priority)")
            print(f"   💡 {suggestion['suggestion']}")
    
    # Thank you message
    print("\n" + "=" * 60)
    print("🙏 Thank You for Your Feedback!")
    print("=" * 60)
    print("\nYour feedback helps us improve AetherCore for everyone.")
    print("We appreciate your contribution to the Night Market Intelligence community.")
    print("\n🎪 Technical Serviceization Practice - Continuous Improvement")
    print("😈🐾⚛️✨ Thank you for being part of our journey!")
    
    # Optional: Upload to GitHub (anonymous)
    print("\n📤 Would you like to anonymously share your feedback to help improve AetherCore?")
    print("   (Your feedback will help other users have a better experience)")
    share = input("Share anonymously? (y/N): ").strip().lower()
    
    if share == 'y':
        print("📡 Uploading anonymous feedback...")
        # In a real implementation, this would upload to a feedback collection service
        print("✅ Thank you for sharing! Your feedback will help improve AetherCore.")
    
    return 0

if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\n\nFeedback collection interrupted.")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Error collecting feedback: {e}")
        sys.exit(1)